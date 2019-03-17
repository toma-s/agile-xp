import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ExerciseService {

  private baseUrl = 'http://localhost:8080/api/exercises';

  constructor(private http: HttpClient) { }

  createExercise(exercise: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}/create`, exercise);
  }

  getExerciseById(id: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/${id}`);
  }

  getExercisesList(): Observable<any> {
    return this.http.get(`${this.baseUrl}`);
  }

  getExercisesByLessonId(lessonId: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/lesson/${lessonId}`);
  }
}
