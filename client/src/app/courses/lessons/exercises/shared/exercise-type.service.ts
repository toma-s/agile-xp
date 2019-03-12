import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ExerciseTypeService {

  private baseUrl = 'http://localhost:8080/api/exercise-types';

  constructor(private http: HttpClient) { }

  getExericseTypesList(): Observable<any> {
    return this.http.get(`${this.baseUrl}`);
  }

  getExerciseTypeByValue(type: string): Observable<any> {
    return this.http.get(`${this.baseUrl}/type/${type}`);
  }
}