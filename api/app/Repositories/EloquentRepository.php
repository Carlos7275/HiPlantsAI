<?php

namespace App\Repositories;

use App\Repositories\Interfaces\RepositoryInterface;
use Illuminate\Database\Eloquent\Model;

class EloquentRepository implements RepositoryInterface
{
    protected $model;

    public function __construct(Model $model)
    {
        $this->model = $model;
    }

    public function exists($id)
    {
        return ($this->model->find($id) != null);
    }
    public function all()
    {
        return $this->model->all();
    }

    public function find($id)
    {

        $exists = ($this->exists($id)) ?
            $this->model->find($id) :
            null;
        return $exists;
    }

    public function create(array $data)
    {
        return $this->model->create($data);
    }

    public function update($id, array $data)
    {
        $record = $this->model->find($id);
        if ($record) {
            $record->update($data);
            return $record;
        }
        return null;
    }

    public function delete($id)
    {
        $record = $this->model->find($id);
        if ($record)
            return $record->delete();
        return null;
    }
}
