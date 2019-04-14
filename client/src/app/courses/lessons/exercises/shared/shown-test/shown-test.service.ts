import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class ShownTestService {

  private baseUrl = `${environment.baseUrl}shown-test`;

  constructor(private http: HttpClient) { }

  createShownTest(shownTest: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}` + `/create`, shownTest);
  }
}
