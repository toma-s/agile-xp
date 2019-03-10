import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class HiddenTestService {

  private baseUrl = 'http://localhost:8080/api/hiddenTest';

  constructor(private http: HttpClient) { }

  createHiddenTest(hiddenTest: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}` + `/create`, hiddenTest);
  }
}
