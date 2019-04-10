import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class SolutionEstimationService {

  private baseUrl = 'http://www.st.fmph.uniba.sk:8080/~savkova3/agile-xp/api/solution-estimations';

  constructor(private http: HttpClient) { }

  estimateSourceTestSolution(exerciseType: string, solutionId: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/estimate/${exerciseType}/${solutionId}`);
  }
}
