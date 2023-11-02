<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="preconnect" href="https://fonts.bunny.net">
    <link href="https://fonts.bunny.net/css?family=figtree:400,600&display=swap" rel="stylesheet" />
    <style>
        .button {
            background-color: blue;
            /* Green */
            border: none;
            color: white;
            color: white;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
        }

        /*==================== 
  Footer 
====================== */

        /* Main Footer */
        footer .main-footer {
            padding: 20px 0;
            background: #252525;
        }

        footer ul {
            padding-left: 0;
            list-style: none;
        }

        /* Copy Right Footer */
        .footer-copyright {
            background: #222;
            padding: 5px 0;
        }

        .footer-copyright .logo {
            display: inherit;
        }

        .footer-copyright nav {
            float: right;
            margin-top: 5px;
        }

        .footer-copyright nav ul {
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .footer-copyright nav ul li {
            border-left: 1px solid #505050;
            display: inline-block;
            line-height: 12px;
            margin: 0;
            padding: 0 8px;
        }

        .footer-copyright nav ul li a {
            color: #969696;
        }

        .footer-copyright nav ul li:first-child {
            border: medium none;
            padding-left: 0;
        }

        .footer-copyright p {
            color: #969696;
            margin: 2px 0 0;
        }

        /* Footer Top */
        .footer-top {
            background: #252525;
            padding-bottom: 30px;
            margin-bottom: 30px;
            border-bottom: 3px solid #222;
        }

        /* Footer transparent */
        footer.transparent .footer-top,
        footer.transparent .main-footer {
            background: transparent;
        }

        footer.transparent .footer-copyright {
            background: none repeat scroll 0 0 rgba(0, 0, 0, 0.3);
        }

        /* Footer light */
        footer.light .footer-top {
            background: #f9f9f9;
        }

        footer.light .main-footer {
            background: #f9f9f9;
        }

        footer.light .footer-copyright {
            background: none repeat scroll 0 0 rgba(255, 255, 255, 0.3);
        }

        /* Footer 4 */
        .footer- .logo {
            display: inline-block;
        }
        .btn {
            background-color: #ff8d1e;
            color: #fff;
        }

        .btn:hover,
        .btn:focus,
        .btn.active {
            background: #4b92dc;
            color: #fff;
            -webkit-box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            -moz-box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            -ms-box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            -o-box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            -webkit-transition: all 250ms ease-in-out 0s;
            -moz-transition: all 250ms ease-in-out 0s;
            -ms-transition: all 250ms ease-in-out 0s;
            -o-transition: all 250ms ease-in-out 0s;
            transition: all 250ms ease-in-out 0s;

        }
    </style>
</head>

<body>
    <h1> {{$subject}} </h1>

    <p> Usuario: {{$email}} </p>
    <a class="button" href="{{$url}}"> Recuperar Cuenta </a>
    <br>

    <footer class="main-footer">
        <div class="footer-copyright">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 text-center">
                        <p>Hi Plants AI ©
                            <?php echo date("Y"); ?> Todos los Derechos Reservados.</p>
                    </div>
                </div>
            </div>
        </div>
    </footer>

</body>

</html>