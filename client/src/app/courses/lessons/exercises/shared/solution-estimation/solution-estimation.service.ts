import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class SolutionEstimationService {

  private baseUrl = 'http://localhost:8080/api/solution-estimations';

  constructor(private http: HttpClient) { }

  estimateSolution(solutionId: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/estimate/${solutionId}`);
  }
}
