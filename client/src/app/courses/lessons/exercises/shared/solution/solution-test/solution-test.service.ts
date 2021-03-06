import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class SolutonTestService {

  private baseUrl = `${environment.baseUrl}solution-tests`;

  constructor(private http: HttpClient) { }

  createSolutionTest(solutionTest: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}/create`, solutionTest);
  }

  getSolutionTestsByExerciseId(exerciseId: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/exercise/${exerciseId}`);
  }
}
