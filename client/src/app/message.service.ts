import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';


@Injectable({
  providedIn: 'root'
})

export class MessageService {

  private baseUrl = 'http://localhost:8080/api/messages';

  constructor(private http: HttpClient) { }

  getMessage(id: number): Observable<Object> {
    return this.http.get(`${this.baseUrl}/${id}`)
  }

  createMessage(message: Object): Observable<Object> {
    console.log(message);
    return this.http.post(`${this.baseUrl}` + `/create`, message)
  }

  updateMesage(id: number, value: any): Observable<Object> {
    return this.http.put(`${this.baseUrl}/${id}`, value)
  }

  deleteMesage(id: number): Observable<any> {
    return this.http.delete(`${this.baseUrl}/${id}`, { responseType: 'text'})
  }

  getMessagesList(): Observable<any> {
    return this.http.get(`${this.baseUrl}`)
  }

  getMessagesBySender(sender: string): Observable<any> {
    return this.http.get(`${this.baseUrl}/sender/${sender}`)
  }

  deleteAll(): Observable<any> {
    return this.http.delete(`${this.baseUrl}` + `/delete`, { responseType: 'text'})
  }
}
