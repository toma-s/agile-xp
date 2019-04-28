import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { PrivateTest } from './private-test.model';

@Injectable({
  providedIn: 'root'
})
export class PrivateTestService {

  private baseUrl = `${environment.baseUrl}private-tests`;

  constructor(private http: HttpClient) { }

  createPrivateTest(exerciseTest: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}` + `/create`, exerciseTest);
  }

  getPrivateTestsByExerciseId(exerciseId: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/exercise/${exerciseId}`);
  }

  updatePrivateTest(id: number, privateTest: PrivateTest): Observable<any> {
    return this.http.put(`${this.baseUrl}/${id}`, privateTest);
  }

  deletePrivateTestsByExerciseId(exerciseId: number) {
    return this.http.delete(`${this.baseUrl}/${exerciseId}`, { responseType: 'text'});
  }
}
