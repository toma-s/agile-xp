import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class SolutonSourceService {

  private baseUrl = 'http://www.st.fmph.uniba.sk:8080/~savkova3/agile-xp/api/solution-sources';

  constructor(private http: HttpClient) { }

  createSolutionSource(solutionSource: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}/create`, solutionSource);
  }
}
