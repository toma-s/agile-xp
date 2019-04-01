import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class SolutionFileService {

  private baseUrl = 'http://localhost:8080/api/solution-files';

  constructor(private http: HttpClient) { }

  createSolutionFile(solutionFile: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}/create`, solutionFile);
  }
}
