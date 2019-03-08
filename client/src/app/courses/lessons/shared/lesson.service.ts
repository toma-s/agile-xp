import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class LessonService {

  private baseUrl = 'http://localhost:8080/api/lessons';

  constructor(private http: HttpClient) { }

  createLesson(lesson: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}` + `/create`, lesson);
  }

  getLessonsByCourseId(id: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/lesson-course-${id}`);
  }

  getLessonById(id: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/lesson-${id}`);
  }
}

// todo getLessonById GetLessonsList deleteLesson deleteAll
