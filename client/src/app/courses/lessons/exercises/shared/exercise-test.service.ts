import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ExerciseTestService {

  private baseUrl = 'http://localhost:8080/api/hiddenTest';

  constructor(private http: HttpClient) { }

  createExerciseTest(hiddenTest: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}` + `/create`, hiddenTest);
  }
}
