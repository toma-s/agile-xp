import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class CourseService {

  private baseUrl = 'http://localhost:8080/api/courses';

  constructor(private http: HttpClient) { }

  createCourse(course: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}/create`, course);
  }

  getCourseById(id: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/${id}`);
  }

  getCoursesList(): Observable<any> {
    return this.http.get(`${this.baseUrl}`);
  }

  deleteCourse(id: number): Observable<any> {
    return this.http.delete(`${this.baseUrl}/${id}`, { responseType: 'text'});
  }

  deleteAll(): Observable<any> {
    return this.http.delete(`${this.baseUrl}/delete`, { responseType: 'text'});
  }
}
