import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class PublicSourceService {

  private baseUrl = `${environment.baseUrl}public-source`;

  constructor(private http: HttpClient) { }

  createPublicSource(publicSource: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}` + `/create`, publicSource);
  }
}
