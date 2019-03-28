import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ColutionConfigService {

  private baseUrl = 'http://localhost:8080/api/solution-configs';

  constructor(private http: HttpClient) { }

  createSolutionConfig(solutionConfig: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}/create`, solutionConfig);
  }
}
