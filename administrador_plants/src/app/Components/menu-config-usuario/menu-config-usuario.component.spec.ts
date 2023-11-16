import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MenuConfigUsuarioComponent } from './menu-config-usuario.component';

describe('MenuConfigUsuarioComponent', () => {
  let component: MenuConfigUsuarioComponent;
  let fixture: ComponentFixture<MenuConfigUsuarioComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [MenuConfigUsuarioComponent]
    });
    fixture = TestBed.createComponent(MenuConfigUsuarioComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
