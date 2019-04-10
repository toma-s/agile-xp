import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ExerciseSourceService {

  private baseUrl = 'http://www.st.fmph.uniba.sk:8080/~savkova3/agile-xp/api/exercise-sources';

  constructor(private http: HttpClient) { }

  createExerciseSource(exerciseSource: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}/create`, exerciseSource);
  }

  getExerciseSourcesByExerciseId(exerciseId: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/exercise/${exerciseId}`);
  }
}
