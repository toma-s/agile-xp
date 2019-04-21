import { Injectable } from '@angular/core';
import { HttpClient, HttpRequest } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { SolutionTest } from '../solution-test/solution-test.model';
import { SolutionFile } from '../solution-file/solution-file.model';
import { SolutionSource } from '../solution-source/solution-source.model';
import { SolutionItems } from '../solution-items/soolution-items.model';

@Injectable({
  providedIn: 'root'
})
export class SolutionEstimationService {

  private baseUrl = `${environment.baseUrl}solution-estimations`;

  constructor(private http: HttpClient) { }

  // estimateSourceTestSolution(exerciseType: string, solutionId: number): Observable<any> {
  //   return this.http.get(`${this.baseUrl}/estimate/${exerciseType}/${solutionId}`);
  // }

  estimateSourceTestSolution(exerciseType: string, solutionItems: SolutionItems): Observable<any> {
    console.log(solutionItems);
    console.log(exerciseType);
    return this.http.post(`${this.baseUrl}/estimate/${exerciseType}`, solutionItems);
  }
}


