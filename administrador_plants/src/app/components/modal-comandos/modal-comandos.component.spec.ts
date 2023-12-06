import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModalComandosComponent } from './modal-comandos.component';

describe('ModalComandosComponent', () => {
  let component: ModalComandosComponent;
  let fixture: ComponentFixture<ModalComandosComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ModalComandosComponent]
    });
    fixture = TestBed.createComponent(ModalComandosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
