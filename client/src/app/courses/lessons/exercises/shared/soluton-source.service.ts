import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class SolutonSourceService {

  private baseUrl = 'http://localhost:8080/api/solutionSourceCodes';

  constructor(private http: HttpClient) { }

  createSolutionSourceCode(solutionSourceCode: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}` + `/create`, solutionSourceCode);
  }
}
