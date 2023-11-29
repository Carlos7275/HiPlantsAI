import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PreviewImagenComponent } from './preview-imagen.component';

describe('PreviewImagenComponent', () => {
  let component: PreviewImagenComponent;
  let fixture: ComponentFixture<PreviewImagenComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [PreviewImagenComponent]
    });
    fixture = TestBed.createComponent(PreviewImagenComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
