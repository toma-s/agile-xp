import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ExerciseService {

  private baseUrl = `${environment.baseUrl}exercises`;

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

  updateExercise(id: number, value: any): Observable<any> {
    return this.http.put(`${this.baseUrl}/${id}`, value);
  }

  deleteExercise(id: number): Observable<any> {
    return this.http.delete(`${this.baseUrl}/${id}`, { responseType: 'text'});
  }
}
