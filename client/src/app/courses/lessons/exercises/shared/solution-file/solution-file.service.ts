import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class SolutionFileService {

  private baseUrl = 'http://www.st.fmph.uniba.sk:8080/~savkova3/agile-xp/api/solution-files';

  constructor(private http: HttpClient) { }

  createSolutionFile(solutionFile: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}/create`, solutionFile);
  }
}
