import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Course } from './course.model';

@Injectable({
  providedIn: 'root'
})
export class CourseService {

  private baseUrl = 'http://localhost:8080/api/courses';

  constructor(private http: HttpClient) { }

  createCourse(course: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}` + `/create`, course);
  }

  getCourseById(id: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/course-${id}`);
  }

  getCoursesList(): Observable<any> {
    return this.http.get(`${this.baseUrl}`);
  }

  deleteCourse(id: number): Observable<any> {
    return this.http.delete(`${this.baseUrl}/delete-${id}`, { responseType: 'text'});
  }

  deleteAll(): Observable<any> {
    return this.http.delete(`${this.baseUrl}` + `/delete`, { responseType: 'text'});
  }

  // TODO: 24-Feb-19 findByAuthor
  // TODO: 24-Feb-19 updateCourse
}
