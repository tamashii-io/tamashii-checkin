import { RECEIVE_MACHINES } from './constants';
import store from  './store';

const ENDPOINTS = {
    machines: '/machines.json'
};

export const fetchMachines = () => {
    $.get(ENDPOINTS.machines)
     .promise()
     .done((data) => { store.dispatch({type: RECEIVE_MACHINES, machines: data}) })
}
