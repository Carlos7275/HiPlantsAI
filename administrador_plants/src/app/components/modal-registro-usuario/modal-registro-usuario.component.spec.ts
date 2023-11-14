import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ModalRegistroUsuarioComponent } from './modal-registro-usuario.component';


describe('ModalRegistroUsuarioComponent', () => {
  let component: ModalRegistroUsuarioComponent;
  let fixture: ComponentFixture<ModalRegistroUsuarioComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ModalRegistroUsuarioComponent]
    });
    fixture = TestBed.createComponent(ModalRegistroUsuarioComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
