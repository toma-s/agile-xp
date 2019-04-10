import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class SolutonService {

  private baseUrl = 'http://www.st.fmph.uniba.sk:8080/~savkova3/agile-xp/api/solutions';

  constructor(private http: HttpClient) { }

  createSolution(solution: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}/create`, solution);
  }
}
