import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModalRegistroplantasComponent } from './modal-registroplantas.component';

describe('ModalRegistroplantasComponent', () => {
  let component: ModalRegistroplantasComponent;
  let fixture: ComponentFixture<ModalRegistroplantasComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ModalRegistroplantasComponent]
    });
    fixture = TestBed.createComponent(ModalRegistroplantasComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
