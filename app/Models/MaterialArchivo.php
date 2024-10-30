<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MaterialArchivo extends Model
{
    use HasFactory;

    protected $fillable = [
        "material_id",
        "archivo",
    ];

    protected $appends = ["url_archivo", "name", "thumb"];

    public function getThumbAttribute()
    {
        $array_archivo = explode(".", $this->archivo);
        $extension = $array_archivo[1];

        $imagenes = ["jpg", "jpeg", "png", "webp", "gif", "jfif"];

        if (in_array($extension, $imagenes)) {
            return asset("files/" . $this->archivo);
        }
        return asset("imgs/attach.png");
    }
    public function getNameAttribute()
    {
        return $this->archivo;
    }

    public function getUrlArchivoAttribute()
    {
        return asset("files/" . $this->archivo);
    }

    public function material()
    {
        return $this->belongsTo(Material::class, 'material_id');
    }
}
