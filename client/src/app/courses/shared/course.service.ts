import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class CourseService {

  private baseUrl = `${environment.baseUrl}courses`;

  constructor(private http: HttpClient) { }

  createCourse(course: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}/create`, course);
  }

  getCourseById(id: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/${id}`);
  }

  getCoursesList(): Observable<any> {
    console.log(this.baseUrl);
    return this.http.get(`${this.baseUrl}`);
  }

  deleteCourse(id: number): Observable<any> {
    return this.http.delete(`${this.baseUrl}/${id}`, { responseType: 'text'});
  }

  updateCourse(id: number, value: any): Observable<Object> {
    return this.http.put(`${this.baseUrl}/${id}`, value);
  }
}
