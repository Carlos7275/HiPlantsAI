import 'dart:async';
import 'dart:convert';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plants_movil/env/local.env.dart';
import 'package:plants_movil/models/Mapa.model.dart';
import 'package:plants_movil/models/Planta.model.dart';
import 'package:plants_movil/services/mapa.service.dart';
import 'package:plants_movil/customicons/leaf_icon_icons.dart';
import 'package:plants_movil/widgets/voz/voz.widget.dart';
import 'package:mime/mime.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:rxdart/rxdart.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final MapController _mapController = MapController();
  List<Mapa> puntos = List.empty();
  LatLng currentLocation = const LatLng(25.781862, -108.990188);

  String? bytes;
  String? imagen;

  final BehaviorSubject<bool> isLoading$ = BehaviorSubject<bool>.seeded(false);

  List<TextEditingController> controllers =
      List.generate(3, (index) => TextEditingController());

  @override
  void initState() {
    super.initState();
    _initMap();
  }

  Future<void> _initMap() async {
    await obtenerPlantasActivas();
    await preguntarPermisos();
    await obtenerUbicacionUsuario();
  }

  Future<void> preguntarPermisos() async {
    final status = await Permission.location.request();
    if (status == PermissionStatus.denied) {
      await preguntarPermisos();
    } else if (status == PermissionStatus.granted) {
      await obtenerUbicacionUsuario();
    }
  }

  Future<void> obtenerPlantasActivas() async {
    puntos = await MapaService().obtenerPlantasActivas();
  }

  Future<void> obtenerUbicacionUsuario() async {
    StreamSubscription<Position>? locationSubscription;

    void handleLocationChanged(Position position) {
      print("Location changed: $position");
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
      });
    }

    void handleLocationError(dynamic error) {
      print("Error obtaining location: $error");
      mostrarAlertaActivarGPS();
    }

    bool servicio = await Geolocator.isLocationServiceEnabled();

    if (servicio) {
      const settings =
          LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 10);

      locationSubscription = Geolocator.getPositionStream(
        locationSettings: settings,
      ).listen(
        handleLocationChanged,
        onError: handleLocationError,
      );
    } else {
      // If location service is not enabled, prompt the user to enable it.
      print("Location service is not enabled. Showing alert.");
      mostrarAlertaActivarGPS();
    }

    // Cancel the location subscription when the widget is disposed.
    locationSubscription?.onDone(() {
      print("Location subscription canceled.");
      locationSubscription?.cancel();
    });

    setState(() {});
  }

  void mostrarAlertaActivarGPS() {
    final currentContext = context;

    showDialog(
      context: currentContext,
      //barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('GPS Desactivado'),
          content: const Text(
            'Por favor, active el GPS para poder utilizar el mapa.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Configuración'),
              onPressed: () async {
                await AppSettings.openAppSettings(
                    type: AppSettingsType.location);

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildMarkers() {
    return MarkerLayer(
      markers: [
        Marker(
          point: currentLocation,
          width: 60,
          height: 60,
          child: const Icon(Icons.account_circle,
              color: Enviroment.secondaryColor),
        ),
        for (var markerData in puntos)
          Marker(
            point: LatLng(markerData.latitud!, markerData.longitud!),
            width: 100,
            height: 100,
            child:
                const Icon(LeafIcon.tree_2, color: Enviroment.secondaryColor),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _dialogBuilder(context);
        },
        foregroundColor: Colors.green,
        backgroundColor: const Color.fromARGB(255, 236, 233, 223),
        child: const Icon(Icons.navigation),
      ),
      body: Stack(children: [
        OrientationBuilder(
          builder: (context, orientation) {
            return LayoutBuilder(
              builder: (context, constraints) {
                double mapWidth, mapHeight;
                if (orientation == Orientation.portrait) {
                  mapWidth = constraints.maxWidth;
                  mapHeight = constraints.maxHeight * 0.75;
                } else {
                  mapWidth = constraints.maxWidth * 0.85;
                  mapHeight = constraints.maxHeight;
                }
                return Row(
                  children: [
                    Center(
                      child: SizedBox(
                        width: mapWidth,
                        height: mapHeight,
                        child: FlutterMap(
                          mapController: _mapController,
                          options: MapOptions(
                            initialCenter: currentLocation,
                            initialZoom: 12,
                          ),
                          children: [
                            TileLayer(
                              userAgentPackageName: "com.example.app",
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              subdomains: const ['a', 'b', 'c'],
                              tileProvider:
                                  FMTC.instance('mapStore').getTileProvider(),
                            ),
                            buildMarkers(),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
        Voz()
      ]),
    );
  }

  void getImage(ImageSource media) async {
    ImagePicker picker = ImagePicker();
    var img = await picker.pickImage(source: media);

    List<int> imageBytes = await img!.readAsBytes();
    final mimeType = lookupMimeType(img.path);

    setState(() {
      bytes = base64Encode(imageBytes);
      imagen = "data:${mimeType ?? "image/png"};base64,$bytes";
    });
  }

  void pickupImage() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Por favor seleccione el medio'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 5)),
                        backgroundColor: MaterialStateProperty.all(
                          Enviroment.secondaryColor,
                        )),
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      getImage(ImageSource.gallery);
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text(
                          'Desde la Galeria',
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 5)),
                        backgroundColor: MaterialStateProperty.all(
                          Enviroment.secondaryColor,
                        )),
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      getImage(ImageSource.camera);
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.camera),
                        Text(
                          'Desde la Camara',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  enviar(BuildContext context) {
    isLoading$.add(true);
    PlantaModel plantaModel = PlantaModel(
      latitud: double.parse(controllers[0].text),
      longitud: double.parse(controllers[1].text),
      imagen: imagen,
    );

    MapaService().registrarPlanta(plantaModel).then((value) {
      String p = value["data"]["nombre_planta"];
      QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              title: "¡Operación Exitosa!",
              text: 'Se registro la planta $p' )
          .then((value) async {
        await obtenerPlantasActivas();
        Navigator.pop(context);
      });
    }).catchError((error) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: jsonDecode(error.body)["message"],
        showConfirmBtn: true,
      );
    });
    isLoading$.add(false);
  }

  void cargarubi() {
    controllers[0].text = currentLocation.latitude.toString();
    controllers[1].text = currentLocation.longitude.toString();
  }

  Future<void> _dialogBuilder(BuildContext context) {
    Container spaceBetween = Container(height: 15);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registro de Planta'),
          content: Column(
            children: [
              Expanded(
                child: bytes != null
                    ? CircleAvatar(
                        backgroundColor: Colors
                            .transparent, // Para que el fondo sea transparente
                        radius: 100,
                        child: ClipOval(
                          child: Image.memory(
                            base64Decode(bytes!),
                            width:
                                200, // El ancho de la imagen dentro del círculo
                            height:
                                200, // La altura de la imagen dentro del círculo
                            fit: BoxFit
                                .cover, // Para cubrir completamente el espacio del CircleAvatar
                          ),
                        ),
                      )
                    : const CircleAvatar(),
              ),
              spaceBetween,
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controllers[0],
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Latitud',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  )
                ],
              ),
              spaceBetween,
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controllers[1],
                      decoration: const InputDecoration(
                        hintText: 'Longitud',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 5)),
                        backgroundColor: MaterialStateProperty.all(
                          Enviroment.secondaryColor,
                        )),
                    onPressed: () async => pickupImage(),
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text(
                          'Elegir imagen',
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 5)),
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 95, 153, 47),
                        )),
                    onPressed: () async => cargarubi(),
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text(
                          'Cargar ubicacion',
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      Colors.blue,
                    )),
                    onPressed: () => setState(() {
                      enviar(context);
                    }),
                    label: const Column(
                      children: [
                        Text(
                          "Guardar planta",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
