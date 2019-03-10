import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class SourceCodeService {

  private baseUrl = 'http://localhost:8080/api/sourceCode';

  constructor(private http: HttpClient) { }

  createSourceCode(sourceCode: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}` + `/create`, sourceCode);
  }
}
