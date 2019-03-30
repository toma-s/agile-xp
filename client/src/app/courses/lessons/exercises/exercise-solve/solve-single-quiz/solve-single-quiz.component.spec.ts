import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SolveSingleQuizComponent } from './solve-single-quiz.component';

describe('SolveSingleQuizComponent', () => {
  let component: SolveSingleQuizComponent;
  let fixture: ComponentFixture<SolveSingleQuizComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SolveSingleQuizComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SolveSingleQuizComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
