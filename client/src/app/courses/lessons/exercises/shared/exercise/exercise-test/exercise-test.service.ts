import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ExerciseTestService {

  private baseUrl = `${environment.baseUrl}private-tests`;

  constructor(private http: HttpClient) { }

  createExerciseTest(exerciseTest: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}` + `/create`, exerciseTest);
  }

  getExerciseTestsByExerciseId(exerciseId: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/exercise/${exerciseId}`);
  }
}
