import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment.prod';

@Injectable({
  providedIn: 'root'
})
export class ExerciseTypeService {

  private baseUrl = `${environment.production}solution-types`;

  constructor(private http: HttpClient) { }

  getExericseTypesList(): Observable<any> {
    return this.http.get(`${this.baseUrl}`);
  }

  getExerciseTypeByValue(type: string): Observable<any> {
    return this.http.get(`${this.baseUrl}/type/${type}`);
  }

  getExerciseTypeById(id: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/${id}`);
  }
}
