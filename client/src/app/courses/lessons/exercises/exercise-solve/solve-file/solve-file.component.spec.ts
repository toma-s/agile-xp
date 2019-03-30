import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SolveFileComponent } from './solve-file.component';

describe('SolveFileComponent', () => {
  let component: SolveFileComponent;
  let fixture: ComponentFixture<SolveFileComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SolveFileComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SolveFileComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
