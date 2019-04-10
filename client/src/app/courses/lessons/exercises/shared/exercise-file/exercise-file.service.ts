import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ExerciseFileService {

  private baseUrl = `${environment.baseUrl}exercise-files`;

  constructor(private http: HttpClient) { }

  createExerciseFile(exerciseFile: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}/create`, exerciseFile);
  }

  getExerciseFilesByExerciseId(exerciseId: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/exercise/${exerciseId}`);
  }
}
