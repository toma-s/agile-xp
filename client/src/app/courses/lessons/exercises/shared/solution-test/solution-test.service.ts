import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment.prod';

@Injectable({
  providedIn: 'root'
})
export class SolutonTestService {

  private baseUrl = `${environment.production}solution-tests`;

  constructor(private http: HttpClient) { }

  createSolutionTest(solutionTest: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}/create`, solutionTest);
  }
}
