import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
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


