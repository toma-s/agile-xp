import { Injectable } from '@angular/core';
import { HttpClient, HttpRequest } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { SolutionTest } from '../solution-test/solution-test.model';
import { SolutionFile } from '../solution-file/solution-file.model';
import { SolutionSource } from '../solution-source/solution-source.model';
import { SolutionItems } from '../solution-items/solution-items.model';

@Injectable({
  providedIn: 'root'
})
export class SolutionEstimationService {

  private baseUrl = `${environment.baseUrl}solution-estimation`;

  constructor(private http: HttpClient) { }

  estimateSolution(exerciseType: string, solutionItems: SolutionItems): Observable<any> {
    return this.http.post(`${this.baseUrl}/estimate/${exerciseType}`, solutionItems);
  }

  getSolutionEstimationsByExerciseIdAndType(exerciseId: number, solutionType: string, pageNumber, pageSize): Observable<any> {
    return this.http.get(`${this.baseUrl}/exercise/${exerciseId}/${solutionType}/${pageNumber}/${pageSize}`);
  }
}


