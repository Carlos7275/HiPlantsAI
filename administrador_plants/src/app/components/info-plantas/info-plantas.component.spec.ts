import { ComponentFixture, TestBed } from '@angular/core/testing';

import { InfoPlantasComponent } from './info-plantas.component';

describe('InfoPlantasComponent', () => {
  let component: InfoPlantasComponent;
  let fixture: ComponentFixture<InfoPlantasComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [InfoPlantasComponent]
    });
    fixture = TestBed.createComponent(InfoPlantasComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
