import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ExerciseConfigService {

  private baseUrl = 'http://localhost:8080/api/exercise-configs';

  constructor(private http: HttpClient) { }

  createExerciseConfig(exerciseConfig: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}/create`, exerciseConfig);
  }

  getExerciseConfigsByExerciseId(exerciseId: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/exercise/${exerciseId}`);
  }
}
