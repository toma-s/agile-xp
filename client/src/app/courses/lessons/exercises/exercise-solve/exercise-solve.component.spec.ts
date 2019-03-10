import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ExerciseSolveComponent } from './exercise-solve.component';

describe('ExerciseSolveComponent', () => {
  let component: ExerciseSolveComponent;
  let fixture: ComponentFixture<ExerciseSolveComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ExerciseSolveComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ExerciseSolveComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
