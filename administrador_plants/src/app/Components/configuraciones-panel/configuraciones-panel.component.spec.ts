import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ConfiguracionesPanelComponent } from './configuraciones-panel.component';

describe('ConfiguracionesPanelComponent', () => {
  let component: ConfiguracionesPanelComponent;
  let fixture: ComponentFixture<ConfiguracionesPanelComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ConfiguracionesPanelComponent]
    });
    fixture = TestBed.createComponent(ConfiguracionesPanelComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
