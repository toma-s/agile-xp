import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class LessonService {

  private baseUrl = 'http://www.st.fmph.uniba.sk:8080/~savkova3/agile-xp/api/lessons';

  constructor(private http: HttpClient) { }

  createLesson(lesson: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}/create`, lesson);
  }

  getLessonsByCourseId(courseId: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/course/${courseId}`);
  }

  getLessonById(id: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/${id}`);
  }

  deleteLesson(id: number): Observable<any> {
    return this.http.delete(`${this.baseUrl}/${id}`, { responseType: 'text'});
  }
}
