import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class SolutionEstimationService {

  private baseUrl = `${environment.baseUrl}solution-estimations`;

  constructor(private http: HttpClient) { }

  estimateSourceTestSolution(exerciseType: string, solutionId: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/estimate/${exerciseType}/${solutionId}`);
  }
}
