import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { PrivateFile } from './private-file.model';

@Injectable({
  providedIn: 'root'
})
export class PrivateFileService {

  private baseUrl = `${environment.baseUrl}private-files`;

  constructor(private http: HttpClient) { }

  createPrivateFile(exerciseFile: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}/create`, exerciseFile);
  }

  getPrivateFilesByExerciseId(exerciseId: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/exercise/${exerciseId}`);
  }

  updatePrivateFile(id: number, privateFile: PrivateFile): Observable<any> {
    return this.http.put(`${this.baseUrl}/${id}`, privateFile);
  }

  deletePrivateFilesByExerciseId(exerciseId: number) {
    return this.http.delete(`${this.baseUrl}/${exerciseId}`, { responseType: 'text'});
  }
}
