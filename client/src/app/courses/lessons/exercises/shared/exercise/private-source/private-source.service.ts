import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class PrivateSourceService {

  private baseUrl = `${environment.baseUrl}private-sources`;

  constructor(private http: HttpClient) { }

  createPrivateSource(exerciseSource: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}/create`, exerciseSource);
  }

  getPrivateSourcesByExerciseId(exerciseId: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/exercise/${exerciseId}`);
  }
}
