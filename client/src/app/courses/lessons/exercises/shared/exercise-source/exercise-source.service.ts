import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment.prod';

@Injectable({
  providedIn: 'root'
})
export class ExerciseSourceService {

  private baseUrl = `${environment.production}exercise-sources`;

  constructor(private http: HttpClient) { }

  createExerciseSource(exerciseSource: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}/create`, exerciseSource);
  }

  getExerciseSourcesByExerciseId(exerciseId: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/exercise/${exerciseId}`);
  }
}
