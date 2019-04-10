import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class SolutonTestService {

  private baseUrl = 'http://www.st.fmph.uniba.sk:8080/~savkova3/agile-xp/api/solution-tests';

  constructor(private http: HttpClient) { }

  createSolutionTest(solutionTest: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}/create`, solutionTest);
  }
}
