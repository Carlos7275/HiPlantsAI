import { ComponentFixture, TestBed } from '@angular/core/testing';

import { GenericCrudComponent } from './generic-crud.component';

describe('GenericCrudComponent', () => {
  let component: GenericCrudComponent;
  let fixture: ComponentFixture<GenericCrudComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [GenericCrudComponent]
    });
    fixture = TestBed.createComponent(GenericCrudComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
