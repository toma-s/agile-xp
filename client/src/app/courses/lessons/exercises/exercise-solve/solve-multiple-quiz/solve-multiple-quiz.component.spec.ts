import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SolveMultipleQuizComponent } from './solve-multiple-quiz.component';

describe('SolveMultipleQuizComponent', () => {
  let component: SolveMultipleQuizComponent;
  let fixture: ComponentFixture<SolveMultipleQuizComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SolveMultipleQuizComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SolveMultipleQuizComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
