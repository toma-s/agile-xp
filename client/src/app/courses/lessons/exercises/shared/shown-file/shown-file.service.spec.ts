import { TestBed } from '@angular/core/testing';

import { ShownFileService } from './shown-file.service';

describe('ShownFileService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: ShownFileService = TestBed.get(ShownFileService);
    expect(service).toBeTruthy();
  });
});
