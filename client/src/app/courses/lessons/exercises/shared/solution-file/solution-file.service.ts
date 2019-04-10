import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class SolutionFileService {

  private baseUrl = `${environment.baseUrl}solution-files`;

  constructor(private http: HttpClient) { }

  createSolutionFile(solutionFile: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}/create`, solutionFile);
  }
}
