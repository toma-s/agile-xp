import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';


@Injectable({
  providedIn: 'root'
})
export class ShownSourceService {

  private baseUrl = `${environment.baseUrl}shown-source`;

  constructor(private http: HttpClient) { }

  createShownSource(shownSource: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}` + `/create`, shownSource);
  }
}
